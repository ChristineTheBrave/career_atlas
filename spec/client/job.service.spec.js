(function() {
  'use strict';

  let expect = chai.expect;

  describe('job service', function(){
    let JobService;
    let $httpBackend;

    beforeEach(module('career_atlas'));

    beforeEach(inject(function(_$httpBackend_, _JobService_){
      JobService = _JobService_;
      $httpBackend = _$httpBackend_;

      $httpBackend
      .whenGET('/api/jobs/')
      .respond([
        {
          "jobtitle": "test job title",
          "company": "test company",
          "url": "test url",
          "latitude": "test latitude",
          "longitude": "test longitude",
          "date_posted": "30 days ago"
        }
      ]);
    }));

    it('should expect the function to be function', function() {
      expect(JobService.createJobSearch).to.be.a('function');
      expect(JobService.saveJobSearch).to.be.a('function');
    });

    it('should create a job search', function() {
      let resultValue = JobService.createJobSearch(
        {
          "jobtitle": "test job title",
          "company": "test company",
          "url": "test url",
          "latitude": "test latitude",
          "longitude": "test longitude",
          "date_posted": "30 days ago"
        }
      );

      resultValue.then(function(data) {
        expect(data).to.be.an('array');
        //  console.info(data);
        expect(data[0].jobtitle).to.be.a('string');
        expect(data[0].company).to.be.a('string');
        expect(data[0].url).to.be.a('string');
        expect(data[0].latitude).to.be.a('string');
        expect(data[0].longitude).to.be.a('string');
        expect(data[0].date_posted).to.be.a('string');
      });
      $httpBackend.flush();
    });
  });
}());
