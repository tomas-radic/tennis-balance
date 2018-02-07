class MatchesController < ApplicationController
  def index
    @single_matches = Match.joins(
      'join match_to_participants as mtps on mtps.match_id = matches.id join players on players.id = mtps.participant_id'
    ).where('mtps.order_nr = ?', 1).where('mtps.participant_type = ?', 'Player').includes(:game_sets)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
