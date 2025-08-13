var builder = WebApplication.CreateBuilder(args);

// Register controllers
builder.Services.AddControllers();

var app = builder.Build();

// Enable routing to controllers
app.UseHttpsRedirection();
app.MapControllers();

app.Run();
