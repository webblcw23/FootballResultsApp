using System.Net.Http.Headers;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

var host = new HostBuilder()
    .ConfigureFunctionsWorkerDefaults()
    .ConfigureServices(s =>
    {
        s.AddHttpClient("sports", client =>
        {
            var baseUrl = Environment.GetEnvironmentVariable("SPORTS_API_BASE") ?? "";
            if (!string.IsNullOrWhiteSpace(baseUrl))
                client.BaseAddress = new Uri(baseUrl);
            var apiKey = Environment.GetEnvironmentVariable("SPORTS_API_KEY");
            if (!string.IsNullOrWhiteSpace(apiKey))
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", apiKey);
            client.DefaultRequestHeaders.UserAgent.ParseAdd("RangersTracker/1.0");
            client.Timeout = TimeSpan.FromSeconds(10);
        });
        s.AddSingleton<RangersClient>();
    })
    .Build();

await host.RunAsync();

public class Endpoints
{
    private readonly RangersClient _client;
    private readonly ILogger _logger;

    public Endpoints(RangersClient client, ILoggerFactory loggerFactory)
    {
        _client = client;
        _logger = loggerFactory.CreateLogger<Endpoints>();
    }

    [Function("Results")]
    public async Task<HttpResponseData> Results([HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "results")] HttpRequestData req)
    {
        var res = req.CreateResponse();
        var data = await _client.GetResultsAsync();
        await res.WriteAsJsonAsync(data);
        return res;
    }

    [Function("Fixtures")]
    public async Task<HttpResponseData> Fixtures([HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "fixtures")] HttpRequestData req)
    {
        var res = req.CreateResponse();
        var data = await _client.GetFixturesAsync();
        await res.WriteAsJsonAsync(data);
        return res;
    }
}
