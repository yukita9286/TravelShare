class Public::SearchesController < ApplicationController

  def search
    # viewのform_tagにて
    # 選択したmodelの値を@modelに代入。
    @model = params["model"]
    # 選択した検索方法の値を@methodに代入。
    @method = params["method"]
    # 検索ワードを@contentに代入。
    @content = params["content"]
    # @model, @content, @methodを代入した、
    # search_forを@recordsに代入。


            # 検索ワードが空白でないことを確認
    if @content.present?
      @records = search_for(@model, @content, @method)
    else
      # 空白の場合は何も検索せず、適切なメッセージを設定
      flash[:notice] = "検索ワードを入力してください。"
      # 何もデータを表示しないようにする
      @records = []
    end

    @records = search_for(@model, @content, @method)


    @records = @records.page(params[:page]) # ページごとに表示

  end

  private
  def search_for(model, content, method)
    # 選択したモデルがuserだったら
    if model == 'customer'
      # 選択した検索方法がが完全一致だったら
      if method == 'perfect'
        Customer.where(name: content)
      # 選択した検索方法がが部分一致だったら
      else
        Customer.where('name LIKE ?', '%'+content+'%')
      end
    # 選択したモデルがpostだったら
    elsif model == 'post_image'
      if method == 'perfect'
        PostImage.where(title: content)
      else
        PostImage.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end
