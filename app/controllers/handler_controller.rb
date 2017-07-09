class HandlerController < ApplicationController

	def jerks
		characters = Character.all.map{|val| val.name}
		render_content({dongs:characters})
	end
	def jerk_sez
		character = Character.where(name:params[:name]).limit(1).first
		if (character==nil)
			failure();
			return;
		end

		rows = params[:rows]||1;
		count = Dialogue.where(speaker_id:character.id).count
		dialogue=[];
		if (rows.to_i>count)
			rows=count
			dialogue = Dialogue.where(speaker_id:character.id).all.map{|row| row.speech}
		else
			rows.to_i.times do
				dialogue.push(Dialogue.limit(1).offset(rand(count)).first.speech)
			end	
		end
		render_content({character:params[:name],stuff:dialogue,rows:rows})
	end
	def any_jerk
		count = Dialogue.count();
		dialogue = Dialogue.select("dialogues.id,dialogues.speech,characters.name").join("join characters on dialogues.speaker_id=characters.id").offset(rand(count)).limit(1);
		render_content({quote:dialogue.speech,name:dialogue.name});
	end

	def discourse
        begin
            comic = Comic.find(params[:id]);
        rescue
			failure();
            return;
        end
        render_content({title:comic.title,rows:get_discourse(comic.id)})
    end
    def random_discourse
        rows = params[:count]||1;
        comics = [];
        count=Comic.count
        rows.to_i.times do
            comic = Comic.limit(1).offset(rand(count)).first;
            comics.push({title:comic.title,dongs:get_discourse(comic.id)})
        end
        render_content({heynow:comics})
    end
    def get_discourse(id)
        return Dialogue.select("characters.id,characters.name,dialogues.speech,dialogues.comic_id").where(comic_id:id).joins("left join characters on dialogues.speaker_id=characters.id").all.map {|row| {learned_gentleman:row.name,wisdom:row.speech,volume:row.comic_id}}
    end
	def search
		page = params[:page]||1
		q = params[:q]
		
		dialogue = Dialogue.select("characters.id,characters.name,dialogues.speech,dialogues.comic_id").where("speech ilike ?","%#{params[:q]}%").joins("join characters on dialogues.speaker_id=characters.id").page(page.to_i).map {|row| {learned_gentleman:row.name,wisdom:row.speech,volume:row.comic_id}}
		render_content({dongs: dialogue,page:page,query:q,urmom:dialogue.size})
	end
end
