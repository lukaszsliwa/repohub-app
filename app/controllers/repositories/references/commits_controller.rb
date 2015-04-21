class Repositories::References::CommitsController < Repositories::References::ApplicationController
  def index
  end

  def show
    @commit = @repository.commits.find_by_sha params[:id]
    @commit_rugged = @reference.git.lookup params[:id]
    @diff = @commit_rugged.parents[0].diff @commit_rugged
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
