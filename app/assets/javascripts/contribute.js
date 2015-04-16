$(document).ready(function() {
    var margin = {top: 0, right: 0, bottom: 0, left: 0},
        width = 265,
        height = 170;

    var per_row = 15;

    var div = d3.select("body").append("div")
        .attr("class", "tooltip")
        .style("opacity", 0);

    $.getJSON($("#commits-calendar").data('url'), function(days) {

        var svg = d3.select("#commits-calendar")
            .attr("width", width)
            .attr("height", height)
            .append("g")
            .attr("transform", "translate(" + (margin.left + width) + "," + (margin.top + height) + ")rotate(180)");

        var data = days.reverse();

        var max = -1;

        $.each(days, function(i) {
            max = Math.max(max, days[i].count);
        });

        svg.selectAll(".cell")
            .data(data)
            .enter().append("rect")
            .attr("class", "cell")
            .on("mouseover", function(d, i) {
                div.transition()
                   .duration(200)
                   .style("opacity", .9);
                div.html('<b>' + data[i].count + ' commits</b> on ' + data[i].date)
                   .style("left", (d3.event.pageX) + "px")
                   .style("top", (d3.event.pageY - 38) + "px");
            })
            .on("mouseout", function(d) {
                div.transition()
                    .duration(500)
                    .style("opacity", 0);
            })
            .attr("x", function (d, i) {
                return (i % (per_row - 1)) * 19;
            })
            .attr("y", function (d, i) {
                return Math.floor(i / (per_row - 1)) * 19;
            })
            .attr('data-date', function (d, i) {
                return data[i].date;
            })
            .attr('data-count', function (d, i) {
                return data[i].count;
            })
            .attr("width", '19px')
            .attr("height", '19px')
            .style('stroke', 'white')
            .style("stroke-width", 3)
            .style("stroke-linejoin", "round")
            .style("fill", function (d, i) {
                return data[i].count == 0 ? '#eeeeee' : '#366f0d';
            })
            .style("opacity", function (d, i) {
                return data[i].count == 0 ? 1 : Math.min(((data[i].count / max) + 0.1), 1);
            });
    });
});