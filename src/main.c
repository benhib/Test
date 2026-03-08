#include <SDL3/SDL.h>

int main(int argc, char **argv) {
    if (SDL_Init(SDL_INIT_VIDEO) != 0) {
        SDL_Log("SDL_Init Error: %s", SDL_GetError());
        return 1;
    }

    SDL_Window *win = SDL_CreateWindow("SDL3 GUI", 640, 480, 0);
    if (!win) {
        SDL_Log("Window failed: %s", SDL_GetError());
        SDL_Quit();
        return 1;
    }

    SDL_Surface *surface = SDL_GetWindowSurface(win);
    SDL_FillRect(surface, NULL, SDL_MapRGB(surface->format, 0, 128, 255));
    SDL_UpdateWindowSurface(win);

    SDL_Event e;
    int running = 1;
    while (running) {
        while (SDL_PollEvent(&e)) {
            if (e.type == SDL_EVENT_QUIT) {
                running = 0;
            }
        }
        SDL_Delay(16);
    }

    SDL_DestroyWindow(win);
    SDL_Quit();
    return 0;
}