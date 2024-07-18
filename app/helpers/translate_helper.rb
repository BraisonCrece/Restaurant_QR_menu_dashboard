module TranslateHelper
  def translate(i18n, active_record = nil)
    return active_record if I18n.locale == :gl

    I18n.t(i18n)
  end

  def build_link(object)
    return object if I18n.locale == :gl

    class_name = object.class.name.underscore
    method_name = "#{class_name}_url"

    "#{send(method_name, object)}?locale=#{I18n.locale}"
  end

  def locale_flag(locale = nil)
    case locale || I18n.locale
    when :es
      'spain.png'
    when :en
      'ingles.png'
    when :fr
      'france.png'
    when :de
      'germany.png'
    when :it
      'italy.png'
    when :ru
      'rusia.png'
    else
      'galicia.png'
    end
  end
end
