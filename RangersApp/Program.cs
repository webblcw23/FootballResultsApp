var builder = WebApplication.CreateBuilder(args);

// Register controllers
builder.Services.AddControllers();
builder.Services.AddHttpClient();
builder.WebHost.UseUrls("http://*:80");




var app = builder.Build();

// Enable routing to controllers
app.UseHttpsRedirection();
app.MapControllers();
app.UseStaticFiles();

app.MapGet("/", () =>
{
    var html = @"
    <html>
    <head>
        <style>
            body { font-family: Arial; padding: 40px; background-color: #f9f9f9; text-align: center; }
            h1 { color: #0a3b6b; }
            a { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #0a3b6b; color: white; text-decoration: none; border-radius: 5px; }
            a:hover { background-color: #083060; }
        </style>
    </head>
    <body>
        <h1>Welcome to Rangers FC Fixtures</h1>
        <p>This app shows the 2025/26 season fixtures and past results for Rangers Football Club.</p>
        <a href='/api/fixtures/html'>View Fixtures</a>
        <a href='/api/results/html'>View Results</a>
    </body>
    </html>";
    
    return Results.Content(html, "text/html");
});






app.Run();
