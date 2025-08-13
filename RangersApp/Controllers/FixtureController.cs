using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

[ApiController]
[Route("api/[controller]")]
public class FixturesController : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetFixtures()
    {
        var filePath = Path.Combine(Directory.GetCurrentDirectory(), "data", "rangers-fixtures.json");

        if (!System.IO.File.Exists(filePath))
            return NotFound("Fixture file not found");

        var json = await System.IO.File.ReadAllTextAsync(filePath);
        var doc = JsonDocument.Parse(json);
        var matches = doc.RootElement.GetProperty("matches");

        var fixtures = new List<object>();

        foreach (var match in matches.EnumerateArray())
        {
            var team1 = match.GetProperty("team1").GetString();
            var team2 = match.GetProperty("team2").GetString();
            var dateStr = match.GetProperty("date").GetString();
            var competition = match.GetProperty("competition").GetString();
            var venue = match.GetProperty("venue").GetString();

            var date = DateTime.Parse(dateStr);
            var opponent = team1 == "Rangers" ? team2 : team1;

            fixtures.Add(new
            {
                Opponent = opponent,
                Date = date.ToString("dd MMM"),
                Competition = competition,
                Venue = venue
            });
        }

        return Ok(fixtures);
    }

    [HttpGet("html")]
    public async Task<IActionResult> GetFixturesAsHtml()
    {
        var filePath = Path.Combine(Directory.GetCurrentDirectory(), "data", "rangers-fixtures.json");

        if (!System.IO.File.Exists(filePath))
            return NotFound("Fixture file not found");

        var json = await System.IO.File.ReadAllTextAsync(filePath);
        var doc = JsonDocument.Parse(json);
        var matches = doc.RootElement.GetProperty("matches");

        var html = @"
        <html>
        <head>
            <style>
                body { font-family: Arial, sans-serif; padding: 20px; }
                table { border-collapse: collapse; width: 100%; }
                th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
                th { background-color: #f4f4f4; }
                tr:nth-child(even) { background-color: #f9f9f9; }
            </style>
        </head>
        <body>
            <h2>Rangers Fixtures 2025/26</h2>
            <table>
                <tr><th>Opponent</th><th>Date</th><th>Competition</th><th>Venue</th></tr>";

        foreach (var match in matches.EnumerateArray())
        {
            var team1 = match.GetProperty("team1").GetString();
            var team2 = match.GetProperty("team2").GetString();
            var dateStr = match.GetProperty("date").GetString();
            var competition = match.GetProperty("competition").GetString();
            var venue = match.GetProperty("venue").GetString();

            var date = DateTime.Parse(dateStr);
            var opponent = team1 == "Rangers" ? team2 : team1;

            html += $"<tr><td>{opponent}</td><td>{date:dd MMM}</td><td>{competition}</td><td>{venue}</td></tr>";
        }

        html += "</table></body></html>";
        return Content(html, "text/html");
    }
}
