class ApplicationController < ActionController::Base
  include Slate::Navigation
  include Slate::Authentication

  # load helpers
  helper :all

  before_filter :capture_user!
  
  # manually load the enclosing resources
  # and then capture the space
  before_filter :load_enclosing_resources
  before_filter :capture_space

protected
  # stub method for non-RC controllers
  def load_enclosing_resources
    # this is a stub method for controllers
    # that do not use RC
  end

  # assigns active space based on instance variable
  # (from resources_controller)
  def capture_space
    Space.active = @space
  end
end