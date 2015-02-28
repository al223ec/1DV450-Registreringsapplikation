module ApiBaseHelper

  def format_url(base, id, nested = nil)
    url = base.clone
    while url.end_with? "/"
      url = url[0..-2]
    end

    if !nested.nil?
      url << '/' << nested
    end

    url_id = url.split("/").last
    if is_numeric?(url_id)
      url.slice! url_id
      url = url[0..-2]
    end

    "#{url}/#{id}"
  end

  def is_numeric?(s)
      !!Float(s) rescue false
  end
end
