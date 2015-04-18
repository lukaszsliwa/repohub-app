class KeysController < ApplicationController
  def index
    @keys = current_user.keys.all
  end

  def new
    @key = Key.new
  end

  def create
    @key = current_user.keys.build params_key

    respond_to do |format|
      if @key.save
        format.html { redirect_to keys_path, notice: 'New key was successfully created.' }
      else
        format.html { render action: :new }
      end
    end
  end

  def edit
    @key = current_user.keys.find params[:id]
  end

  def update
    @key = current_user.keys.find params[:id]

    respond_to do |format|
      if @key.save
        format.html { redirect_to keys_path, notice: 'Key was successfully updated.' }
      else
        format.html { render action: :edit }
      end
    end
  end

  def destroy
    @key = current_user.keys.find params[:id]
    @key.destroy

    redirect_to keys_path, notice: 'Key was successfully deleted.'
  end

  private

  def params_key
    params[:key].permit(:name, :value)
  end
end
