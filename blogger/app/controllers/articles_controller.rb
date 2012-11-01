class ArticlesController < ApplicationController
	before_filter :require_login, :except => [:index, :show]

	def index
		@articles = Article.all

		case params[:type]
		when 'awesome'
		    @articles = Article.find(:all, :limit => 2, :order => 'views desc')
		    @articles_displayed = 'Awesome'
		when 'month'
			if ((1..12).include?(params[:month].to_i))
	        @articles = Article.by_month(params[:month].to_i, :field => :created_at)
	        @articles_displayed = Date::MONTHNAMES[params[:month].to_i]
		    end
		end

		@articles = Article.find(:all)

	    respond_to do |format|
	      format.html
	      format.xml { render :xml => @articles.to_xml }
	    end

	end
	def show
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.article_id = @article.id
		@viewCount = @article.article_view_count
	    @random_color = Polychromasia::ColorPicker.new.random_colors_to_hex
	end
	def new
		@article = Article.new
	end
	def create
		@article = Article.new (params[:article])
		@article.save

		flash[:message] = "Article '#{@article.title}' was successfully created."

		redirect_to article_path(@article)
	end
	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash[:message] = "Your article '#{@article.title}' was nuked!"

		redirect_to articles_path
	end
	def edit
		@article = Article.find(params[:id])
	end
	def update
		@article = Article.find(params[:id])
		@article.update_attributes(params[:article])

		flash[:message] = "Article '#{@article.title}' Updated!"

		redirect_to article_path(@article)
	end
end
