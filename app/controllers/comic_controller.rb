class ComicController < ApplicationController
	
	def index
		begin
			comic = Comic.find(params[:id]);
		rescue
			render json: {status:0,message:"Comic not found."};
			return;
		end
		render json: {title:comic.title,rows:dialogue(comic.id)}
	end
	def random
		rows = params[:count]||1;
		comics = [];
		count=Comic.count 
		rows.to_i.times do
			comic = Comic.limit(1).offset(rand(count)).first;
			comics.push({title:comic.title,dongs:dialogue(comic.id)})
		end
		render json: {heynow:comics}
	end
	def dialogue(id)
        return Dialogue.select("characters.id,characters.name,dialogues.speech").where(comic_id:id).joins("join characters on dialogues.speaker_id=characters.id").all
	end

		
		
end
