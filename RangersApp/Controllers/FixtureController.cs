using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

[ApiController]
[Route("api/[controller]")]
public class FixturesController : ControllerBase
{
    private readonly IWebHostEnvironment _env;

    public FixturesController(IWebHostEnvironment env)
    {
        _env = env;
    }

    private async Task<List<object>> LoadFixtures()
    {
        var path = Path.Combine(_env.ContentRootPath, "Data", "rangers-fixtures.json");

        if (!System.IO.File.Exists(path))
            return new List<object>();

        var json = await System.IO.File.ReadAllTextAsync(path);
        var doc = JsonDocument.Parse(json);
        var fixtures = new List<object>();

        foreach (var match in doc.RootElement.GetProperty("fixtures").EnumerateArray())
        {
            var opponent = match.GetProperty("opponent").GetString();
            var date = match.GetProperty("date").GetString();
            var time = match.GetProperty("time").GetString();
            var competition = match.GetProperty("competition").GetString();
            var venue = match.GetProperty("venue").GetString();
            var status = match.GetProperty("status").GetString();

            fixtures.Add(new
            {
                Opponent = opponent,
                Date = date,
                Time = time,
                Competition = competition,
                Venue = venue,
                Status = status
            });
        }

        return fixtures;
    }

    [HttpGet]
    public async Task<IActionResult> GetFixtures()
    {
        var fixtures = await LoadFixtures();
        return Ok(fixtures);
    }

    [HttpGet("html")]
    public async Task<IActionResult> GetFixturesHtml()
    {
        var fixtures = await LoadFixtures();

        var html = @"
        <html>
        <head>
            <style>
                body { font-family: Arial, sans-serif; padding: 20px; background-color: #f9f9f9; }
                table { border-collapse: collapse; width: 100%; margin-top: 20px; }
                th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
                th { background-color: #0a3b6b; color: white; }
                tr:nth-child(even) { background-color: #eef2f7; }
                .logo { max-width: 100px; height: auto; border: 2px solid #0a3b6b; box-shadow: 0 2px 6px rgba(0,0,0,0.2); border-radius: 8px; }
                .header { display: flex; align-items: center; gap: 20px; }
            </style>
        </head>
        <body>
            <div class='header'>
                <img src='/images/rangers-logo.png' class='logo' alt='Rangers FC Logo' />
                <h2>Rangers Fixtures 2025/26</h2>
            </div>
            <table>
            <div style='margin-top: 30px; text-align: center;'>
    <a href='/' style='
        display: inline-block;
        padding: 12px 24px;
        background-color: #0a3b6b;
        color: white;
        text-decoration: none;
        font-weight: bold;
        border-radius: 6px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        transition: background-color 0.3s ease;
    '>Back to Home</a>
</div>

                <tr><th>Opponent</th><th>Date</th><th>Time</th><th>Competition</th><th>Venue</th><th>Status</th></tr>"
                ;

                

        foreach (var fixture in fixtures)
        {
            html += $"<tr><td>{fixture.GetType().GetProperty("Opponent")?.GetValue(fixture)}</td>";
            html += $"<td>{fixture.GetType().GetProperty("Date")?.GetValue(fixture)}</td>";
            html += $"<td>{fixture.GetType().GetProperty("Time")?.GetValue(fixture)}</td>";
            html += $"<td>{fixture.GetType().GetProperty("Competition")?.GetValue(fixture)}</td>";
            html += $"<td>{fixture.GetType().GetProperty("Venue")?.GetValue(fixture)}</td>";
            html += $"<td>{fixture.GetType().GetProperty("Status")?.GetValue(fixture)}</td></tr>";
        }

        html += "</table></body></html>";
        return Content(html, "text/html");
    }


    [HttpGet("/api/results/html")]
public async Task<IActionResult> GetResultsHtml()
{
    var path = Path.Combine(_env.ContentRootPath, "Data", "rangers-results.json");

    if (!System.IO.File.Exists(path))
        return Content("<h2>No results available</h2>", "text/html");

    var json = await System.IO.File.ReadAllTextAsync(path);
    var doc = JsonDocument.Parse(json);
    var results = doc.RootElement.GetProperty("results").EnumerateArray();

    var html = @"
    <html>
    <head>
        <style>
            body { font-family: Arial; padding: 20px; background-color: #f9f9f9; }
            table { border-collapse: collapse; width: 100%; margin-top: 20px; }
            th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
            th { background-color: #0a3b6b; color: white; }
            tr:nth-child(even) { background-color: #eef2f7; }
            .logo { max-width: 100px; height: auto; border: 2px solid #0a3b6b; box-shadow: 0 2px 6px rgba(0,0,0,0.2); border-radius: 8px; }
            .header { display: flex; align-items: center; gap: 20px; }
        </style>
    </head>
    <body>
        <div class='header'>
            <img src='/images/rangers-logo.png' class='logo' alt='Rangers FC Logo' />
            <h2>Rangers Results 2025/26</h2>
        </div>
        <table>
        <div style='margin-top: 30px; text-align: center;'>
    <a href='/' style='
        display: inline-block;
        padding: 12px 24px;
        background-color: #0a3b6b;
        color: white;
        text-decoration: none;
        font-weight: bold;
        border-radius: 6px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        transition: background-color 0.3s ease;
    '>Back to Home</a>
</div>

            <tr><th>Opponent</th><th>Date</th><th>Time</th><th>Competition</th><th>Venue</th><th>Score</th><th>Status</th></tr>";

    foreach (var match in results)
    {
        html += $"<tr><td>{match.GetProperty("opponent").GetString()}</td>";
        html += $"<td>{match.GetProperty("date").GetString()}</td>";
        html += $"<td>{match.GetProperty("time").GetString()}</td>";
        html += $"<td>{match.GetProperty("competition").GetString()}</td>";
        html += $"<td>{match.GetProperty("venue").GetString()}</td>";
        html += $"<td>{match.GetProperty("score").GetString()}</td>";
        html += $"<td>{match.GetProperty("status").GetString()}</td></tr>";
    }

    html += "</table></body></html>";
    return Content(html, "text/html");
}

}
