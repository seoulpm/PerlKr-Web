#!/usr/bin/env perl

use utf8;

use Mojolicious::Lite;

use Text::MultiMarkdown;

my $m = Text::MultiMarkdown->new(
    tab_width     => 2,
    use_wikilinks => 0,
);

app->defaults( %{ plugin 'Config' => { default => {
    m => $m,
}}});

get '/'           => 'index';
get '/contribute' => 'contribute';
get '/donate'     => 'donate';

app->start;

__DATA__
@@ index.html.ep
% layout 'default';
% title 'Home of the Perl Korea';

% for my $link (@$perl_sites) {
  <li>
    <div class="galery">
      <div class="image-galery">
        <a class="group" rel="group1" href="<%= $link->{image} %>">
          <img src="<%= $link->{thumbnail} %>?<%= $cache_ver %>" />
        </a>
      </div>
      <div class="count-galery">
        <h3>
          <i class="icon-certificate"></i>
          <a href="<%= $link->{url} %>">
            <%= $link->{title} %>
          </a>
        </h3>
      </div>
      <div class="tags-galery">
        <p>
          <i class="icon-comment"></i>
          <%= $link->{desc} %>
        </p>
      </div>
    </div>
  </li>
% }


@@ contribute.html.ep
% layout 'subpage';
% title 'How To Contribute';

<%== $m->markdown($page_contribute) %>


@@ donate.html.ep
% layout 'subpage';
% title 'Donate Us';

<%== $m->markdown($page_donate) %>


@@ layouts/default.html.ep
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>perl.kr - <%= title %></title>
    %= include 'layouts/head-load'
  </head>

  <body>
    <div id="wrapper" class="clearfix">
      %= include 'layouts/nav'

      <div class="container">
        <div class="row" id="wookmark">
          <ul id="tiles">

            <li>
              %= include 'layouts/header'
            </li>
            <%= content %>

          </ul>
        </div> <!-- /row -->
      </div> <!-- /container -->

      %= include 'layouts/footer'
    </div> <!-- /wrapper -->

    %= include 'layouts/body-load'
  </body>
</html>


@@ layouts/head-load.html.ep
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<meta name="verify-v1" content="J4/HArGFld3FzWJ406poZ3byQKb2vhQ5kYt2Zriqh4g=" />

<!-- Le styles -->
<link type="text/css" rel="stylesheet" href="/gallery/css/bootstrap.css?<%= $cache_ver %>" />
<link type="text/css" rel="stylesheet" href="/gallery/css/style.css?<%= $cache_ver %>" />
<link type="text/css" rel="stylesheet" href="/gallery/css/icon-style.css?<%= $cache_ver %>" />
<link type="text/css" rel="stylesheet" href="/gallery/css/bootstrap-responsive.css?<%= $cache_ver %>" />
<link type="text/css" rel="stylesheet" href="/gallery/source/jquery.fancybox.css?<%= $cache_ver %>" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
  <script type="text/javascript" src="http://html5shim.googlecode.com/svn/trunk/html5.js?<%= $cache_ver %>"></script>
<![endif]-->

<!-- Le fav and touch icons -->
<link type="image/x-icon" rel="shortcut icon" href="/favicon.ico?<%= $cache_ver %>" />
<link type="image/x-icon" rel="icon" href="/favicon.ico?<%= $cache_ver %>" />


@@ layouts/body-load.html.ep
<!-- Le javascript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="/gallery/js/jquery-1.7.2.min.js?<%= $cache_ver %>"></script>
<script type="text/javascript" src="/gallery/js/bootstrap.js?<%= $cache_ver %>"></script>
<script type="text/javascript" src="/gallery/js/image-gallery.js?<%= $cache_ver %>"></script>
<script type="text/javascript" src="/gallery/js/jquery.mousewheel-3.0.6.pack.js?<%= $cache_ver %>"></script>
<script type="text/javascript" src="/gallery/source/jquery.fancybox.js?<%= $cache_ver %>"></script>

<!-- like pinterest layout using wookmark -->
<script src="/wookmark/jquery.wookmark.min.js?<%= $cache_ver %>"></script>
<script type="text/javascript">
      // Call the layout function.
      $('#tiles > li').wookmark({
        autoResize: true,          // This will auto-update the layout when the browser window is resized.
        container: $('#wookmark'), // Optional, used for some extra CSS styling
        offset: 20,                // Optional, the distance between grid items
        itemWidth: 280             // Optional, the width of a grid item
      });
</script>

<!-- google analytics -->
<script type="text/javascript">
  var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
  document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
  try {
    var pageTracker = _gat._getTracker("<%= $google_analytics %>");
    pageTracker._trackPageview();
  } catch(err) {}
</script>


@@ layouts/header.html.ep
<div id="header">
  <div class="nav-headers">
    <h3><%= $header_title %></h3>
    <p> <%= $header_desc %> </p>
  </div>
  <ul class="nav nav-tabs nav-stacked">
    % for my $link (@$header_links) {
      <li><a href="<%= $link->{url} %>"><i class="icon-ok"></i> <%= $link->{title} %> </a></li>
    % }
  </ul>
</div>


@@ layouts/footer.html.ep
<div class="container footer">
  <hr class="alt" />
  <div class="row">
    <div class="span6">&copy; <%= $copyright %>. All Rights Reserved.</div>
    <div class="span6">
      <ul>
        <li>Built by <a href="http://www.perl.org/">Perl</a> &amp; <a href="http://mojolicio.us/">Mojolicious</a></li>
      </ul>
    </div>
  </div>
</div>

@@ layouts/nav.html.ep
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container-fluid">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <a class="brand" href="/"><img src="/gallery/img/logo.png?<%= $cache_ver %>" alt="<%= $project_name %>" /></a>
      <div class="nav-collapse">
        <ul class="nav">
            % for my $link (@$header_links) {
                <li><a href="<%= $link->{url} %>"> <%= $link->{title} %> </a></li>
            % }
          <li>
            <form class="navbar-search pull-left" action="http://www.google.com/cse" id="searchbox_009035706704064932538:p1hkg-zoke4">
              <input type="hidden" name="cx" value="009035706704064932538:p1hkg-zoke4" />
              <input type="text" class="search-query span2" placeholder="Search" required name="q" />
            </form>
          </li>
        </ul>
        <ul class="nav pull-right">
          <li><a href="<%= $twitter %>"> Twitter </a></li>
          <li><a href="<%= $facebook %>"> Facebook </a></li>
        </ul>
      </div><!--/.nav-collapse -->
    </div>
  </div>
</div>


@@ layouts/error.html.ep
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>perl.kr - <%= title %></title>
    %= include 'layouts/head-load'
  </head>

  <body>
    <div id="wrapper" class="clearfix">
      %= include 'layouts/nav'

      <div class="error-container">
        <h1>Oops!</h1>

        <%= content %>

        <div class="error-actions">
          <a href="./" class="btn btn-large btn-primary">
            <i class="icon-chevron-left"></i>
            &nbsp;
            Back to perl.kr
          </a>
          <a href="./" class="btn btn-large">
            <i class="icon-envelope"></i>
            &nbsp;
            Contact Support
          </a>
        </div> <!-- /error-actions -->

      </div> <!-- /error-container -->

      %= include 'layouts/footer'
    </div> <!-- /wrapper -->

    %= include 'layouts/body-load'
  </body>
</html>


@@ not_found.html.ep
% layout 'error';
% title '404 Not Found';
<h2>404 Not Found</h2>

<div class="error-details">
  Sorry, an error has occured, Requested page not found!
</div> <!-- /error-details -->


@@ layouts/subpage.html.ep
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>perl.kr - <%= title %></title>
    %= include 'layouts/head-load'
  </head>

  <body>
    <div id="wrapper" class="clearfix">
      %= include 'layouts/nav'

      <div class="container">
        <div class="row">
          <div class="span3">
            %= include 'layouts/header'
          </div>
          <div class="span8 subpage">
            <%= content %>
          </div>
        </div> <!-- /row -->
      </div> <!-- /container -->

      %= include 'layouts/footer'
    </div> <!-- /wrapper -->

    %= include 'layouts/body-load'
  </body>
</html>
