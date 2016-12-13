class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    positions = JSON.parse(params[:user][:position])
    eye = get_length(positions["right_eye"], positions["nose"])
    mouth = get_length(positions["left_eye"], positions["nose"])
    logger.info "eye: " + eye.to_s
    logger.info "mouth: " + mouth.to_s
    @user.position = mouth / eye.to_f
    @user.save
    logger.info "ratio: " + @user.position.to_s
  end

  def login
    @user = User.new
  end

  def auth
    @user = User.where(email: params[:user][:email], password: params[:user][:password])
    if @user == nil
      redirect_to root_path
    else
      redirect_to "/face_auth/#{@user[0].id}"
    end
  end

  def face_auth
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def check
    user = User.find(params[:user_id])
    logger.info params[:right_eye]
    if (params[:right_eye][0].to_f - params[:left_eye][0].to_f).abs <= 100
      head 500
      return
    end
    eye = get_length(params[:right_eye], params[:nose])
    mouth = get_length(params[:left_eye], params[:nose])
    distance = (user.position.to_f - mouth / eye.to_f).abs
    if distance <= 0.01
      session[:user_id] = user.id
      head 200
      return
    end
    render text: distance, status: 401
  end

  def complete

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
  def get_length(pos_a, pos_b)
    x = (pos_a[0].to_f - pos_b[0].to_f).abs
    y = (pos_a[1].to_f - pos_b[1].to_f).abs
    Math.sqrt(x * x + y * y).floor
  end
end
