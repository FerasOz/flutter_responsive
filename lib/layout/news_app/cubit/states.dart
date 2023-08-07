abstract class NewsStates {}

class NewsInitialStates extends NewsStates{}

class NewsBottomNAvBarStates extends NewsStates{}

class NewsSelectBusinessItemStates extends NewsStates{}

class NewsSetDesktopStates extends NewsStates{}

class NewsGetBusinessLoadingStates extends NewsStates{}

class NewsGetBusinessSuccessStates extends NewsStates{}

class NewsGetBusinessErrorStates extends NewsStates{

  final error;

  NewsGetBusinessErrorStates(this.error);
}

class NewsGetSportsLoadingStates extends NewsStates{}

class NewsGetSportsSuccessStates extends NewsStates{}

class NewsGetSportsErrorStates extends NewsStates{

  final error;

  NewsGetSportsErrorStates(this.error);
}

class NewsGetScienceLoadingStates extends NewsStates{}

class NewsGetScienceSuccessStates extends NewsStates{}

class NewsGetScienceErrorStates extends NewsStates{

  final error;

  NewsGetScienceErrorStates(this.error);
}

class NewsGetSearchLoadingStates extends NewsStates{}

class NewsGetSearchSuccessStates extends NewsStates{}

class NewsGetSearchErrorStates extends NewsStates{

  final error;

  NewsGetSearchErrorStates(this.error);
}