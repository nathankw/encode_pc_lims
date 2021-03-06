require 'rails_helper'

RSpec.describe "chromosomes/new", type: :view do
  before(:each) do
    assign(:chromosome, Chromosome.new(
      :name => "MyString",
      :user => nil,
      :reference_genome => nil
    ))
  end

  it "renders new chromosome form" do
    render

    assert_select "form[action=?][method=?]", chromosomes_path, "post" do

      assert_select "input#chromosome_name[name=?]", "chromosome[name]"

      assert_select "input#chromosome_user_id[name=?]", "chromosome[user_id]"

      assert_select "input#chromosome_reference_genome_id[name=?]", "chromosome[reference_genome_id]"
    end
  end
end
