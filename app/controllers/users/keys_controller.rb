class Users::KeysController < Users::ApplicationController
  def index
    @keys = @user.keys.all
  end

  def new
    @key = Key.new
  end

  def create
    @key = @user.keys.build params_key

    respond_to do |format|
      if @key.save
        format.html { redirect_to user_keys_path(@user), notice: 'New key was successfully created.' }
      else
        format.html { render action: :new }
      end
    end
  end

  def edit
    @key = @user.keys.find params[:id]
  end

  def update
    @key = @user.keys.find params[:id]

    respond_to do |format|
      if @key.save
        format.html { redirect_to user_keys_path(@user), notice: 'Key was successfully updated.' }
      else
        format.html { render action: :edit }
      end
    end
  end

  def destroy
    @key = @user.keys.find params[:id]
    @key.destroy

    redirect_to user_keys_path(@user), notice: 'Key was successfully deleted.'
  end

  private

  def params_key
    params[:key].permit(:name, :value)
  end
end
