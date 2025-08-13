var builder = WebApplication.CreateBuilder(args);

// Register controllers
builder.Services.AddControllers();
builder.Services.AddHttpClient();



var app = builder.Build();

// Enable routing to controllers
app.UseHttpsRedirection();
app.MapControllers();
app.UseStaticFiles();


app.Run();
