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
    if wine
      adjusted_y = size_y - 100

      processed_image = ImageProcessing::Vips
        .source(file)
        .resize_to_fit(size_x, size_y)
        .resize_and_pad(size_x, adjusted_y, extend: :white)
        .call
    else
      processed_image = ImageProcessing::Vips
      .source(file)
      .resize_to_limit(size_x, size_y)
      .call
    end

    record.public_send(attachment_name).attach(
      io: File.open(processed_image.path),
      filename: "p_#{file.original_filename}",
    )
  end
end
