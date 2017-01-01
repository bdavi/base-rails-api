RSpec.shared_examples "TextSearchable" do |columns|
  let(:factory_name) { described_class.name.underscore }

  context "describe search_by scope" do
    columns.each do |column|
      it "can search by #{column} with a single term" do
        exact_match = create(factory_name)
          .tap {|o| o.update_attribute column, "S-o!m22'e" }
        beginning_match = create(factory_name)
          .tap {|o| o.update_attribute column, "S-o!m22'e text here!!!" }
        ending_match = create(factory_name)
          .tap {|o| o.update_attribute column, "2k.sdf S-o!m22'e" }
        middle_match = create(factory_name)
          .tap {|o| o.update_attribute column, "text S-o!m22'e goes here" }
        partial_word_match = create(factory_name)
          .tap {|o| o.update_attribute column, "text bbS-o!m22'e. goes here" }
        case_insensitive_match = create(factory_name)
          .tap {|o| o.update_attribute column, "s-o!M22'e" }
        does_not_match = create(factory_name)
          .tap {|o| o.update_attribute column, "No match in this string." }

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
        exact_match = create(factory_name)
          .tap {|o| o.update_attribute column, "H3LLO thERe!!! word" }
        spaced_match = create(factory_name)
          .tap {|o| o.update_attribute column, "H3LLO 123..thERe!!! tacos word" }
        out_of_order_match = create(factory_name)
          .tap {|o| o.update_attribute column, " thERe!!! 11word  dde H3LLO" }
        incomplete_match = create(factory_name)
          .tap {|o| o.update_attribute column, "word stuff 3234!!!" }
        does_not_match = create(factory_name)
          .tap {|o| o.update_attribute column, "No match in this string." }

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
          record.update_attribute columns[0], "123..thERe!!!"
          record.update_attribute columns[1], "b*(bb cccG1((ERISHcc H1xq!!.."
        end
        does_not_match = create(factory_name)

        expect(described_class.search_by("THer Xq!!..")).to eq [multi_column_match]
      end
    end
  end
end
