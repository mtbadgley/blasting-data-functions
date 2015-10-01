using NUnit.Framework;
using TechTalk.SpecFlow;

namespace NPIRemediation.Specs
{
    [Binding]
    public class NpiRemediationSteps
    {
        readonly NPIRemediation _remediation = new NPIRemediation();
        private string _evaluation;
        private string _pattern;
        private string[] _patterns;

        [Given(@"I have supplied a string of ""(.*)""")]
        public void GivenIHaveSuppliedAStringOf(string p0)
        {
            Assert.IsNotEmpty(p0);
            _evaluation = p0;
        }
        
        [Given(@"I scan using this pattern ""(.*)""")]
        public void GivenIScanUsingThisPattern(string p0)
        {
            Assert.IsNotEmpty(p0);
            _pattern = p0;
        }

        [When(@"I don't find a match")]
        public void WhenIDontFindAMatch()
        {
            Assert.IsFalse(_remediation.FindMatch(_evaluation, _pattern));
        }

        [When(@"I find a match")]
        public void WhenIFindAMatch()
        {
            Assert.IsTrue(_remediation.FindMatch(_evaluation,_pattern));
        }
        
        [Then(@"the result should be a string of ""(.*)""")]
        public void ThenTheResultShouldBeAStringOf(string p0)
        {
            string result = _remediation.ReplaceAll(_evaluation,_pattern);
            Assert.AreEqual(result,p0);
        }

        [When(@"I have an array of patterns to match")]
        public void WhenIHaveAnArrayOfPatternsToMatch()
        {
            _patterns = new[] { @"\b((67\d{2})|(4\d{3})|(5[1-5]\d{2})|(6011))-?\s?\d{4}-?\s?\d{4}-?\s?\d{4}\b", @"\b([0-6]\d{2}|7[0-6]\d|77[0-2])(\s|\-)?(\d{2})\2(\d{4})\b", @"\b[0-9]{8} \b" };
        }

        [Then(@"the result should be ""(.*)""")]
        public void ThenTheResultShouldBe(string p0)
        {
            string result = _remediation.RemoveNPI(_evaluation,_patterns);
            Assert.AreEqual(result,p0);
        }

    }
}
