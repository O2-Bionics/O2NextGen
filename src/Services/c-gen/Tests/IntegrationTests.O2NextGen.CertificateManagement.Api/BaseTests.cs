using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Testing;
using O2NextGen.CertificateManagement.Web;
using Xunit;

namespace IntegrationTests.O2NextGen.CertificateManagement.Api
{
    public class BaseTests : IClassFixture<WebApplicationFactory<Startup>>
    {
        private readonly WebApplicationFactory<Startup> _factory;

        public BaseTests(WebApplicationFactory<Startup> factory)
        {
            _factory = factory;
        }
        
        [Theory]
        // [InlineData("/")]
        [InlineData("/certificates")]
        // [InlineData("/About")]
        // [InlineData("/Privacy")]
        // [InlineData("/Contact")]
        public async Task Get_EndpointsReturnSuccessAndCorrectContentType(string url)
        {
            // Arrange
            var client = _factory.CreateClient();

            // Act
            var response = await client.GetAsync(url);

            // Assert
            response.EnsureSuccessStatusCode(); // Status Code 200-299
            Assert.Equal("application/json; charset=utf-8", 
                response.Content.Headers.ContentType.ToString());
        }
    }
}