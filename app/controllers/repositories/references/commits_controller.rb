class Repositories::References::CommitsController < Repositories::References::ApplicationController
  def index
  end

  def show
    @commit = Git::Commit.find params[:id], params: { repository_id: @repository.handle }
  end

  def count
    from = Date.parse(params[:from]) rescue nil
    to   = Date.parse(params[:to]) rescue nil
    if from.present? && to.present?
      @dates = from..to
    elsif from.present?
      @dates = [from]
    elsif to.present?
      @dates = [to]
    end
  end
end
