using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

[ApiController]
[Route("api/[controller]")]
public class ResultsController : ControllerBase
{
    private readonly IWebHostEnvironment _env;

    public ResultsController(IWebHostEnvironment env)
    {
        _env = env;
    }

    [HttpGet("html")]
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
                <img src='/images/rangers-logo.png' class='logo' alt='Rangers FC Logo' />
                <h2>Rangers Results 2025/26</h2>
            <table>
                <tr><th>Date</th><th>Home</th><th>Away</th><th>Venue</th><th>Score</th></tr>";

        foreach (var match in results)
        {
            html += "<tr>";
            html += $"<td>{match.GetProperty("date").GetString()}</td>";
            html += $"<td>{match.GetProperty("home").GetString()}</td>";
            html += $"<td>{match.GetProperty("away").GetString()}</td>";
            html += $"<td>{match.GetProperty("venue").GetString()}</td>";
            html += $"<td>{match.GetProperty("score").GetString()}</td>";
            html += "</tr>";
        }

        html += @"
            </table>
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
        </body>
        </html>";

        return Content(html, "text/html");
    }
}
