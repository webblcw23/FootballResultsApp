using System.Net.Http.Json;

public record MatchDto(DateTime date, string opponent, string? score, string competition);

public class RangersClient
{
    private readonly IHttpClientFactory _http;
    private readonly string _teamId;
    private readonly bool _demoMode;

    public RangersClient(IHttpClientFactory http)
    {
        _http = http;
        _teamId = Environment.GetEnvironmentVariable("TEAM_ID") ?? "rangers";
        _demoMode = string.IsNullOrWhiteSpace(Environment.GetEnvironmentVariable("SPORTS_API_KEY"));
    }

    public async Task<List<MatchDto>> GetResultsAsync()
    {
        if (_demoMode) return DemoResults();
        try
        {
            // Example — shape depends on your provider. Keep generic to avoid lock-in.
            var client = _http.CreateClient("sports");
            var uri = Environment.GetEnvironmentVariable("RESULTS_PATH") ?? "/teams/rangers/results";
            var data = await client.GetFromJsonAsync<dynamic>(uri);
            return MapResults(data);
        }
        catch
        {
            return DemoResults();
        }
    }

    public async Task<List<MatchDto>> GetFixturesAsync()
    {
        if (_demoMode) return DemoFixtures();
        try
        {
            var client = _http.CreateClient("sports");
            var uri = Environment.GetEnvironmentVariable("FIXTURES_PATH") ?? "/teams/rangers/fixtures";
            var data = await client.GetFromJsonAsync<dynamic>(uri);
            return MapFixtures(data);
        }
        catch
        {
            return DemoFixtures();
        }
    }

    private static List<MatchDto> MapResults(dynamic data)
    {
        // TODO: map provider response -> MatchDto
        return DemoResults();
    }

    private static List<MatchDto> MapFixtures(dynamic data)
    {
        // TODO: map provider response -> MatchDto
        return DemoFixtures();
    }

    private static List<MatchDto> DemoResults() => new()
    {
        new(DateTime.UtcNow.AddDays(-1), "Dundee FC", "1–1", "Scottish Premiership"),
        new(DateTime.UtcNow.AddDays(-5), "Viktoria Plzeň", "3–0", "UEFA Champions League"),
        new(DateTime.UtcNow.AddDays(-8), "Motherwell", "1–1", "Scottish Premiership")
    };

    private static List<MatchDto> DemoFixtures() => new()
    {
        new(DateTime.UtcNow.AddDays(2), "Viktoria Plzeň", null, "UEFA Champions League"),
        new(DateTime.UtcNow.AddDays(6), "Alloa", null, "League Cup")
    };
}
