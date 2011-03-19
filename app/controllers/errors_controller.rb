class ErrorsController < ApplicationController
    
    def not_found
        respond_to do |format|
            format.html {
                render :template => "errors/not_found", :layout => 'application', :status => :not_found
            }
            format.all { render :nothing => true, :status => :not_found }
        end
    end
    
    def unprocessable_entity
        respond_to do |format|
            format.html {
                render :template => "errors/unprocessable_entity", :layout => 'application', :status => :unprocessable_entity
            }
            format.all { render :nothing => true, :status => :unprocessable_entity }
        end
    end
    
    def internal_server_error
        respond_to do |format|
            format.html {
                render :template => "errors/internal_server_error", :layout => 'application', :status => :internal_server_error
            }
            format.all { render :nothing => true, :status => :internal_server_error }
        end
    end
    
end
