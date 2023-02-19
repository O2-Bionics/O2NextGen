using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using O2NextGen.CertificateManagement.Application.Features.Categories;
using O2NextGen.CertificateManagement.Application.Features.Projects;

namespace IntegrationTests.O2NextGen.CertificateManagement.Application.Features;

public class ProjectsApiTests :
    BaseIntegrationApiTests
{
    [Fact]
    public async Task Projects_GetById_Test()
    {
        // Act
        //var webAppFactory = new CustomWebApplicationFactory<Program>();//
        //var _httpClient = webAppFactory.CreateDefaultClient();
        const string url = "/api/v1.0/Projects/1";
        var response = await _httpClient.GetAsync(url);

        // Assert
        response.EnsureSuccessStatusCode(); // Status Code 200-299
        Assert.Equal("application/json; charset=utf-8",
            response.Content.Headers.ContentType?.ToString());
    }

    [Fact]
    public async Task Projects_Get_Test()
    {
        // Act
        // var webAppFactory = new CustomWebApplicationFactory<Program>();//
        // var _httpClient = webAppFactory.CreateDefaultClient();
        const string url = "api/v1.0/Projects";
        var response = await _httpClient.GetAsync(url);

        // Assert
        response.EnsureSuccessStatusCode(); // Status Code 200-299
        Assert.Equal("application/json; charset=utf-8",
            response.Content.Headers.ContentType?.ToString());
    }

    [Fact]
    public async Task Projects_Update_Test()
    {
        // Act
        // var webAppFactory = new CustomWebApplicationFactory<Program>();//
        // var _httpClient = webAppFactory.CreateDefaultClient();
        const string url = "/api/v1.0/Projects";
        var addItem = new CreateCategoryModel
        {
            CategoryName = "Update",
            CategoryDescription = "Update Description",
            CategorySeries = "UPD",
            QuantityCertificates = 1,
            QuantityPublishCode = 10
        };
        var ser = JsonConvert.SerializeObject(addItem);
        var content = new StringContent(ser,
            Encoding.UTF8, "application/json");
        var response = await _httpClient.PostAsync(url, content);

        // Assert
        response.EnsureSuccessStatusCode(); // Status Code 200-299
        Assert.Equal("application/json; charset=utf-8",
            response.Content.Headers.ContentType?.ToString());
    }

    [Fact]
    public async Task Projects_Add_Test()
    {
        // Act
        // var webAppFactory = new CustomWebApplicationFactory<Program>();//
        // var _httpClient = webAppFactory.CreateDefaultClient();
        const string url = "/api/v1.0/Projects";
        var addItem = new CreateProjectModel
        {
            // CategoryName = "Update",
            // CategoryDescription = "Update Description",
            // CategorySeries = "UPD",
            // QuantityCertificates = 1,
            // QuantityPublishCode = 10
        };
        var ser = JsonConvert.SerializeObject(addItem);
        var content = new StringContent(ser,
            Encoding.UTF8, "application/json");
        var response = await _httpClient.PostAsync(url, content);

        // Assert
        response.EnsureSuccessStatusCode(); // Status Code 200-299
        Assert.Equal("application/json; charset=utf-8",
            response.Content.Headers.ContentType?.ToString());
    }

    [Fact]
    public async Task Projects_Delete_Test()
    {
        // Act
        // var webAppFactory = new CustomWebApplicationFactory<Program>();//
        // var _httpClient = webAppFactory.CreateDefaultClient();
        const string url = "/api/v1.0/Projects/2";
        var response = await _httpClient.DeleteAsync(url);

        // Assert
        response.EnsureSuccessStatusCode(); // Status Code 200-299
        Assert.Null(
            response.Content.Headers.ContentType);
    }
}