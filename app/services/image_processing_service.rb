class ImageProcessingService
  attr_reader :file, :record, :attachment_name

  def initialize(file:, record:, attachment_name:, size_x: 1024, size_y: 480)
    @file = file
    @record = record
    @attachment_name = attachment_name
    @size_x = size_x
    @size_y = size_y
  end

  def call
    processed_image = ImageProcessing::Vips
      .source(file)
      .resize_to_limit(@size_x, @size_y)
      .call

    record.public_send(attachment_name).attach(
      io: File.open(processed_image.path),
      filename: "p_#{file.original_filename}",
    )
  end
end
