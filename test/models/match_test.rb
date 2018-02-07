require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  test "evaluation of match, match not completed yet" do
    match_not_completed = matches(:match_not_completed)
    match_not_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_not_completed.game_sets.new(sequence_nr: 2, games: [6, 3])
    match_not_completed.save
    match_not_completed.evaluate!
    assert_nil match_not_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player won 2:0" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [6, 3])
    match_completed.save
    match_completed.evaluate!
    assert_equal 0, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player won 2:1" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 3, games: [6, 3])
    match_completed.save
    match_completed.evaluate!
    assert_equal 0, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player won 2:1, with meaningless tiebreak" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 3, games: [6, 3], tiebreak: [3, 7])
    match_completed.save
    match_completed.evaluate!
    assert_equal 0, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player won 2:1, with meaningless supertiebreak" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 3, games: [6, 3], supertiebreak: [3, 7])
    match_completed.save
    match_completed.evaluate!
    assert_equal 0, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player lost 1:2" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 3, games: [3, 6])
    match_completed.save
    match_completed.evaluate!
    assert_equal 1, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player lost 0:2" do
    match_completed = matches(:match_completed)
    
    match_completed.game_sets.new(sequence_nr: 1, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 2, games: [3, 6])
    match_completed.save
    match_completed.evaluate!
    assert_equal 1, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player won 2:1, third set tiebreak only" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 3, tiebreak: [7, 3])
    match_completed.save
    match_completed.evaluate!
    assert_equal 0, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player won 2:1, third set tiebreak only, meaningless supertiebreak" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 3, tiebreak: [7, 3], supertiebreak: [5, 10])
    match_completed.save
    match_completed.evaluate!
    assert_equal 0, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, first player won 2:1, third set supertiebreak only" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.game_sets.new(sequence_nr: 3, supertiebreak: [10, 8])
    match_completed.save
    match_completed.evaluate!
    assert_equal 0, match_completed.winning_participant_order_nr
  end

  test "evaluation of match, match marked completed, no winner" do
    match_completed = matches(:match_completed)
    match_completed.game_sets.new(sequence_nr: 1, games: [6, 4])
    match_completed.game_sets.new(sequence_nr: 2, games: [2, 6])
    match_completed.save
    match_completed.evaluate!
    assert_nil match_completed.winning_participant_order_nr
  end
end
