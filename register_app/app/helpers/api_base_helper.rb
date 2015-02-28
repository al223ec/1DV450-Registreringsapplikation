module ApiBaseHelper

  def format_url(name,id)
    url = root_url
    "#{url}#{name}/#{id}"
  end
end
