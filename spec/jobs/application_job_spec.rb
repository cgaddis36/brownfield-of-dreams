require 'rails_helper'

RSpec.describe "Application Job" do
  it "exists" do
    job = ApplicationJob.new
    expect(job.class).to eq(ApplicationJob)
  end
end
