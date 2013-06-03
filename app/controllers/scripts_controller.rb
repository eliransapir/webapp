class ScriptsController < ApplicationController
	before_filter :require_login

	def list
    @scripts = current_user.scripts.valid
	end

	def create
    script = Script.safe_create(params)
    script.user = current_user
    script.save
    unless script.valid?
      flash[:error] = "Script creation failed"
    end
    redirect_to :action => :list
	end

  def lastrun
    @script = Script.find(params[:scriptname])
  end

  def edit
    @script = Script.find(params[:scriptname])
  end

  def delete
    @script = Script.find(params[:scriptname])
    if @script
      @script.update_attribute :deleted, true
      flash[:success]="Script #{@script.name} deleted."
    end
    redirect_to :controller => :scripts, :action => :list
  end
end