# frozen_string_literal: true

# Controls the behavior of articles on the website
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  # GET /articles or /articles.json
  def index
    @subscriber = Subscriber.new
    @subscriber_count = Subscriber.count
    if user_signed_in? && current_user.admin?
      @pagy, @articles = pagy(Article.order('created_at DESC'), items: 4)
    else
      @pagy, @articles = pagy(Article.where(publicly_published: true).order('created_at DESC'), items: 4)
    end

    if params[:payment] == 'success'
      flash[:notice] = 'Votre don a été reçu avec succès. Merci pour votre générosité !'
      redirect_to root_path
    elsif params[:payment] == 'cancel'
      flash[:alert] = 'Votre don a été annulé.'
      redirect_to root_path
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.friendly.find(params[:id])

    return if @article.publicly_published || current_user&.admin? || current_user == @article.user

    flash[:notice] = "Cet article n'est pas disponible publiquement"
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Cet article n'existe pas"
    redirect_to root_path
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: 'Article bel et bien créé' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    clean_category_ids

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: 'Article bel et bien modifié' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article supprimé avec succès' }
      format.json { head :no_content }
    end
  end

  def search
    @articles = if params[:title_search].present?
                  Article.filter_by_title(params[:title_search]).where(publicly_published: true)
                else
                  []
                end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('search_results',
                                                 partial: 'articles/search_results', locals: { articles: @articles })
      end
      format.html
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :subtitle, :body, :image, :publicly_published, :summary, category_ids: [])
  end

  def require_same_user
    if current_user.nil?
      flash[:danger] = 'Vous devez vous connecter pour faire cela'
      redirect_to new_user_session_path
    elsif current_user != @article.user && !current_user.admin?
      flash[:danger] = "Tu te crois ou la Tony. C'est pas ton article"
      redirect_to root_path
    end
  end

  def clean_category_ids
    params[:article][:category_ids].reject!(&:blank?) if params[:article][:category_ids].present?
  end
end
