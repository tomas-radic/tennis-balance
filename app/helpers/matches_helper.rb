module MatchesHelper
  
  # Builds and returns html safe table of given single match.
  def table_of_single(matches)
    content = nil

    if matches.any?
      match_rows = []
      matches.select('matches.*, players.name as pname').each do |match| 
        match_rows << row_for_single(match)
      end

      content = content_tag :table, class: 'table' do
        match_rows.join.html_safe
      end
    else
      content = content_tag :p, t('.no_matches')
    end

    content.html_safe
  end

  # Builds and returns html safe table row of given single match.
  def row_for_single(match)
    row = content_tag :tr do
      cells = []
      
      cell = content_tag :td do 
        formatted_date(match.date_played) 
      end
      cells << cell

      cell = content_tag :td do
        match['pname']
      end
      cells << cell



      cell = content_tag :td do 
        match.place 
      end
      cells << cell

      cell = content_tag :td do 
        match.surface 
      end
      cells << cell

      cell = content_tag :td do
        match.environment
      end

      cells.join.html_safe
    end

    row.html_safe
  end
end
