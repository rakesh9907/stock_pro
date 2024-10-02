class SubBookmarksController < ApplicationController
  before_action :set_bookmark
  before_action :set_sub_bookmark, only: [:show, :update, :destroy]

  # GET /bookmarks/:bookmark_id/sub_bookmarks
  def index
    @sub_bookmarks = @bookmark.sub_bookmarks
    render json: @sub_bookmarks, each_serializer: SubBookmarkSerializer
  end

  # GET /bookmarks/:bookmark_id/sub_bookmarks/:id
  def show
    render json: @sub_bookmark, serializer: SubBookmarkSerializer
  end

  # POST /bookmarks/:bookmark_id/sub_bookmarks
  def create
    @sub_bookmark = @bookmark.sub_bookmarks.new(sub_bookmark_params)

    if @sub_bookmark.save
      render json: @sub_bookmark, serializer: SubBookmarkSerializer, status: :created
    else
      render json: @sub_bookmark.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookmarks/:bookmark_id/sub_bookmarks/:id
  def update
    if @sub_bookmark.update(sub_bookmark_params)
      render json: @sub_bookmark, serializer: SubBookmarkSerializer
    else
      render json: @sub_bookmark.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookmarks/:bookmark_id/sub_bookmarks/:id
  def destroy
    @sub_bookmark.destroy
    head :no_content
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:bookmark_id])
  end

  def set_sub_bookmark
    @sub_bookmark = @bookmark.sub_bookmarks.find(params[:id])
  end

  def sub_bookmark_params
    params.permit(:stock_id, :added_price, :added_date)
  end
end
