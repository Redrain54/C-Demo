using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.Features;
using Pomelo.EntityFrameworkCore.MySql.Infrastructure;
using TravelApi.Dao;
using TravelApi.Service;

namespace TravelApi
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        { 
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContextPool<TravelContext>(options => options
            .UseMySql(Configuration.GetConnectionString("travelDataBase"),
            mySqlOptions => mySqlOptions.ServerVersion(new Version(5, 7, 30), ServerType.MySql)
            ));
            services.Configure<FormOptions>(o => 
            {  
                o.MultipartBodyLengthLimit = Int32.MaxValue;  
            });
            services.AddTransient<IUserService, UserService>();
            services.AddTransient<IDiaryService, DiaryService>();
            services.AddTransient<IRouteService, RouteService>();
            services.AddTransient<ISiteService, SiteService>();
            services.AddTransient<ITaskService, TaskService>();
            services.AddTransient<ITravelService, TravelService>();
            services.AddControllers().ConfigureApiBehaviorOptions(options =>
            {
                options.SuppressConsumesConstraintForFormFileParameters = true;
                //options.SuppressInferBindingSourcesForParameters = true;
                options.SuppressModelStateInvalidFilter = true;
                options.SuppressMapClientErrors = true;
            });
            services.AddMvc().AddXmlSerializerFormatters();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
