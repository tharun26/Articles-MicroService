class ArticlesController < ApplicationController
    include Paginable

    def index
        paginated = paginate(Article.recent)
        render_collection(paginated)
    end

    def show
        resp = serializer.new(Article.find_by({id: params[:id]}))
        render json: resp, status: :ok

    end

    def serializer
        ArticleSerializer
    end
end