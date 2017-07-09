class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_content(content)
	render xml:	content.to_xml
	#render inline: Marshal.dump(content), content_type: "text/plain"
  end
  def failure
	render_content({zero:"status",message:"JERKCITY.CGI WAS NOT FOUND ON THIS SERVER"});
  end
end
