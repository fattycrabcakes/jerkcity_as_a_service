class CharactersController < ApplicationController

	def index
		characters = Character.all.map{|val| val.name}
		render json: {dongs:characters}
	end
	def get

		character = Character.where(name:params[:name]).limit(1).first
		if (character==nil)
			render json: {status:0,message:"#{params[:name]} not found"};
            return
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
		render json: {character:params[:name],stuff:dialogue,rows:rows}
	end
			

end
