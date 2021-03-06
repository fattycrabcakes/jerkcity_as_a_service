class HandlerController < ApplicationController

	def jerks
		jerks = Character.all.map{|val| val.name}
		render_content({dongs:jerks})
	end
	def jerk_sez
		jerk = Character.where(name:params[:name]).limit(1).first
		if (jerk==nil)
			failure();
			return;
		end

		rows = params[:rows]||1;
		count = Dialogue.where(speaker_id:jerk.id).count
		dialogue=[];
		if (rows.to_i>count)
			rows=count
			dialogue = Dialogue.where(speaker_id:jerk.id).all.map{|row| row.speech}
		else
			rows.to_i.times do
				dialogue.push(Dialogue.limit(1).offset(rand(count)).first.speech)
			end	
		end
		render_content({jerk:params[:name],stuff:dialogue,rows:rows})
	end
	def any_jerk
		count = Dialogue.count();
		dialogue = Dialogue.select("dialogues.comic_id,dialogues.id,dialogues.speech,characters.name").joins("join characters on dialogues.speaker_id=characters.id").offset(rand(count)).limit(1).map {|row| {gurgling:row.speech,jerk:row.name,number:row.comic_id}}.first;
		render_content(dialogue);
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
        return Dialogue.select("characters.id,characters.name,dialogues.speech,dialogues.comic_id").where(comic_id:id).joins("left join characters on dialogues.speaker_id=characters.id").all.map {|row| {jerk:row.name,gurgling:row.speech,volume:row.comic_id}}
    end
	def search
		page = params[:page]||1
		q = params[:q]
		
		dialogue = Dialogue.select("characters.id,characters.name,dialogues.speech,dialogues.comic_id").where("speech ilike ?","%#{params[:q]}%").joins("join characters on dialogues.speaker_id=characters.id").page(page.to_i).map {|row| {jerk:row.name,gurgling:row.speech,volume:row.comic_id}}
		render_content({dongs: dialogue,page:page,query:q,urmom:dialogue.size})
	end
	def version
		render_content({version:"Enterprise Alhpa 8===D"});
	end
	def operations
		render_content([
			{name:"List of Available Jerks",url:"/jerks",method:"get"},
			{name:"Make a jerk speak doesn't matter who",url:"/jerks/any",method:"get"},
			{name:"Make a specific jerk speak",url:"/jerks/:jerk",method:"get"},
			{name:"Make a specific jerk speak x times",url:"/jerks/:jerk/:x",method:"get"},
			{name:"A conversation doesn't matter which",url:"/circlejerk/any",method:"get"},
			{name:"A number of conversations, doesn't matter which",url:"/circlejerk/:count",method:"get"},
			{name:"A conversation does matter which",url:"/circlejerk/:id",method:"get"},
			{name:"Search",url:"/search/:query",method:"get"},
			{name:"More results",url:"/search/:query/:page",method:"get"},
			{name:"DICKLICKING",url:"/ur/mouth",method:"put"},
		])
	end
	def hurgleburgle
		render_content({response:"GBLAGHBALGLUAHGBLAGHLABLAHGBLAGA"});
	end
end
