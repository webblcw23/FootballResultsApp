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
            .logo { max-width: 100px; height: auto; border: 2px solid #0a3b6b; box-shadow: 0 2px 6px rgba(0,0,0,0.2); border-radius: 8px; }
            a { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #0a3b6b; color: white; text-decoration: none; border-radius: 5px; }
            a:hover { background-color: #083060; }
        </style>
    </head>
    <body>
    <img src='/images/rangers-logo.png' class='logo' alt='Rangers FC Logo' />
    <div class='header'>
        <h2>Rangers Results 2025/26</h2>
    </div>
        <h1>Welcome to Rangers FC Fixtures</h1>
        <p>This app shows the 2025/26 season past results for Rangers Football Club.</p>
        <a href='/api/results/html'>View Results</a>
    </body>
    </html>";
    
    return Results.Content(html, "text/html");
});






app.Run();
