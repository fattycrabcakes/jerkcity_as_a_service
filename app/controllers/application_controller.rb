class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'base64'

  def render_content(content)
	case params[:format] 
		when "json"
			render json: content
		when "xml"
			render xml:	content.to_xml
		when "bson"

		when "none"
			render inline: "OK Buddy whateve", content_type: "text/plain"
		else
			render inline: Base64.encode64(Marshal.dump(content)), content_type: "text/plain"
	end
  end
  def failure
	render_content({zero:"status",message:"JERKCITY.CGI WAS NOT FOUND ON THIS SERVER"});
  end
end
