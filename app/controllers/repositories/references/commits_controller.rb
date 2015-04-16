class Repositories::References::CommitsController < Repositories::References::ApplicationController
  def index
  end

  def show
    @commit = @reference.git.lookup params[:id]
    @diff = @commit.parents[0].diff @commit
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
