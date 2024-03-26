class ApplicationController < ActionController::Base
   before_action :authenticate_admin!, if: :admin_url
   
   
   #pathに/adminが含まれている全てのページは、adminでログインしないと見ることができない
  def admin_url
    request.fullpath.include?("/admin")
  end



end
