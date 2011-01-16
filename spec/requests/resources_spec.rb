require 'spec_helper'

describe 'API resource' do

  describe 'with JS format and no callback' do
    before { get '/datasets.js' }

    it_behaves_like 'a JSON 400 error'

    it 'has a reasonable error message' do
      response.json[:message].should include "can not be requested without specifying a callback"
    end
  end

  describe 'with JSON format and callback' do
    before { get '/datasets.json?callback=test' }

    it_behaves_like 'a JSON 400 error'

    it 'has a reasonable error message' do
      response.json[:message].should include "can not be requested with a callback"
    end
  end

  describe 'with default format and callback' do
    before { get '/datasets?callback=test' }

    it 'returns JSON-P' do
      response.should be_jsonp
    end
  end

  describe 'with default format and no callback' do
    before { get '/datasets' }

    it 'returns JSON' do
      response.should be_json
    end
  end

  describe 'with CSV format and callback' do
    before { get '/datasets.csv?callback=test' }

    it 'returns CSV and ignores the callback' do
      response.should be_csv
    end
  end

  describe 'with TSV format and callback' do
    before { get '/datasets.tsv?callback=test' }

    it 'returns TSV and ignores the callback' do
      response.should be_tsv
    end
  end

  describe 'with invalid callback' do
    before { get '/datasets.js?callback=window.boom' }

    it_behaves_like 'a JSON 400 error'

    it 'returns JSON' do
      response.should be_json
    end
  end

end
