# frozen_string_literal: true

ActiveSupport::Notifications.subscribe('new_item_translated') do |_name, _start, _finish, _id, payload|
  item = payload[:item]
  result = payload[:result]
  item.update(lock: false)
  item.update(active: true)
  Rails.logger.info("Item #{item.class.name} #{item.id} translated: #{result}")
end
