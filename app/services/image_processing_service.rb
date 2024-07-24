class ImageProcessingService
  attr_reader :file, :record, :attachment_name, :size_x, :size_y, :wine

  def initialize(file:, record:, attachment_name:, wine: false, size_x: 1200, size_y: 675)
    @file = file
    @record = record
    @attachment_name = attachment_name
    @wine = wine
    @size_x = size_x
    @size_y = size_y
  end

  def call
    image = Vips::Image.new_from_file(file.path, access: :sequential)

    if image.bands == 4
      image = image.flatten(background: [255, 255, 255])
    end

    if wine
      adjusted_y = size_y - 100

      processed_image = ImageProcessing::Vips
        .source(image)
        .resize_to_fit(size_x, size_y)
        .resize_and_pad(size_x, adjusted_y, extend: :white)
        .convert('webp')
        .saver(Q: 75, strip: true)
        .call
      else
        processed_image = ImageProcessing::Vips
          .source(image)
          .resize_to_fit(size_x, size_y)
          .convert('webp')
          .saver(Q: 75, strip: true)
          .call
    end

    record.public_send(attachment_name).attach(
      io: File.open(processed_image.path),
      filename: "p_#{file.original_filename}",
    )
  end
end
