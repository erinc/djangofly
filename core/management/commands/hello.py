from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = 'Say hello to the world'

    def handle(self, *args, **kwargs):
        self.stdout.write(self.style.SUCCESS('Hello, world!'))            