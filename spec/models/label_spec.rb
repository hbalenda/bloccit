require 'rails_helper'

RSpec.describe Label, type: :model do

  it { is_expected.to have_many :labelings }
  it { is_expected.to have_many(:topics).through(:labelings) }
  it { is_expected.to have_many(:posts).through(:labelings) }

end
