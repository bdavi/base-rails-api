RSpec.shared_examples "TextSearchable" do |columns|
  let(:factory_name) { described_class.name.underscore }

  def create_match(column, value)
    match = create(factory_name)
    update_match_from_column match, column, value
    match
  end

  def update_match_from_column match, column, value
    if column_is_for_association column
      update_match_association_from_column match, column, value
    else
      match.update_attribute column, value
    end
  end

  def column_is_for_association column
    column.to_s =~ /\./
  end

  def update_match_association_from_column match, column, value
    association_name, column_name = column.to_s.split(".")
    association = match.class.reflect_on_all_associations
      .find { |association| association.name == association_name.to_sym }
    association_contents = match.public_send(association_name)

    if association.macro == :has_many
      record_to_update = association_contents.first
    else
      record_to_update = association_contents
    end

    record_to_update.update_attribute column_name, value
  end

  context "describe search_by scope" do
    columns.each do |column|
      it "can search by #{column} with a single term" do
        exact_match = create_match(column, "S-o!m22'e")
        beginning_match = create_match(column, "S-o!m22'e text here!!!")
        ending_match = create_match(column, "2k.sdf S-o!m22'e")
        middle_match = create_match(column, "text S-o!m22'e goes here")
        partial_word_match = create_match(column, "text bbS-o!m22'e. goes here")
        case_insensitive_match = create_match(column, "s-o!M22'e")
        does_not_match = create_match(column, "No match in this string.")

        matches = Set[
          exact_match,
          beginning_match,
          ending_match,
          middle_match,
          partial_word_match,
          case_insensitive_match
        ]

        expect(described_class.search_by("S-o!m22'e").to_set).to eq matches
      end

      it "can search by #{column} with multiple terms" do
        exact_match = create_match(column, "H3LLO thERe!!! word")
        spaced_match = create_match(column, "H3LLO 123..thERe!!! tacos word")
        out_of_order_match = create_match(column, " thERe!!! 11word  dde H3LLO")
        incomplete_match = create_match(column, "word stuff 3234!!!")
        does_not_match = create_match(column, "No match in this string.")

        matches = Set[
          exact_match,
          spaced_match,
          out_of_order_match
        ]

        expect(described_class.search_by("H3LLO thERe!!! word").to_set).to eq matches
      end
    end

    if columns.size > 1
      it "can search by multiple columns and multiple terms" do
        multi_column_match = create(factory_name).tap do |record|
          update_match_from_column record, columns[0], "123..thERe!!!"
          update_match_from_column record, columns[1], "b*(bb cccG1((ERISHcc H1xq!!.."
        end
        does_not_match = create(factory_name)

        expect(described_class.search_by("THer Xq!!..")).to eq [multi_column_match]
      end
    end
  end
end
